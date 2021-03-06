require 'spec_helper'

module Showcase::Helpers
  describe SeoMetaBuilder do

    let(:view) { RailsViewContext.new }
    let(:builder) { double('SeoMetaBuilder') }

    subject { SeoMetaBuilder.new(view) }

    describe '#title' do
      it 'produces a <title/> tag' do
        expect(subject.title('foo')).to have_tag(:title, text: 'foo')
      end

      it 'produces a og:title meta tag' do
        expect(subject.title('foo')).to have_tag(:meta, with: { property: 'og:title', content: 'foo' })
      end

      it 'produces a twitter:title meta tag' do
        expect(subject.title('foo')).to have_tag(:meta, with: { name: 'twitter:title', content: 'foo' })
      end

      context 'with multiple values' do
        it 'uses the first non-blank' do
          expect(subject.title(['', nil, 'foo'])).to have_tag(:title, text: 'foo')
        end
      end

      context 'with a :title_suffix option' do
        it 'produces a <title/> tag with the suffix' do
          expect(subject.title('foo', title_suffix: ' - bar')).to have_tag(:title, text: 'foo - bar')
        end
        it 'does not suffix meta tags' do
          expect(subject.title('foo')).to have_tag(:meta, with: { property: 'og:title', content: 'foo' })
          expect(subject.title('foo')).to have_tag(:meta, with: { name: 'twitter:title', content: 'foo' })
        end
      end
    end

    describe '#description' do
      it 'produces a description meta tag' do
        expect(subject.description('foo')).to have_tag(:meta, with: { name: 'description', content: 'foo' })
      end

      it 'produces a og:description meta tag' do
        expect(subject.description('foo')).to have_tag(:meta, with: { property: 'og:description', content: 'foo' })
      end

      it 'produces a twitter:description meta tag' do
        expect(subject.description('foo')).to have_tag(:meta, with: { name: 'twitter:description', content: 'foo' })
      end

      context 'with multiple values' do
        it 'uses the first non-blank' do
          expect(subject.description(['', nil, 'foo'])).to have_tag(:meta, with: { name: 'description', content: 'foo' })
        end
      end
    end

    describe '#image_url' do
      it 'produces a og:image meta tag' do
        expect(subject.image_url('foo')).to have_tag(:meta, with: { property: 'og:image', content: 'foo' })
      end

      it 'produces a twitter:image meta tag' do
        expect(subject.image_url('foo')).to have_tag(:meta, with: { name: 'twitter:image', content: 'foo' })
      end

      context 'with multiple values' do
        it 'uses the first non-blank' do
          expect(subject.image_url(['', nil, 'foo'])).to have_tag(:meta, with: { property: 'og:image', content: 'foo' })
        end
      end
    end

    describe '#canonical_url' do
      it 'produces a og:url meta tag' do
        expect(subject.canonical_url('foo')).to have_tag(:meta, with: { property: 'og:url', content: 'foo' })
      end

      it 'produces a twitter:url meta tag' do
        expect(subject.canonical_url('foo')).to have_tag(:meta, with: { name: 'twitter:url', content: 'foo' })
      end

      it 'produces a canonical link tag' do
        expect(subject.canonical_url('foo')).to have_tag(:link, with: { rel: 'canonical', href: 'foo' })
      end

      context 'with multiple values' do
        it 'uses the first non-blank' do
          expect(subject.canonical_url(['', nil, 'foo'])).to have_tag(:meta, with: { property: 'og:url', content: 'foo' })
        end
      end
    end

    describe '#iframe_video_url' do
      it 'produces a og:video:url meta tag' do
        expect(subject.iframe_video_url('foo')).to have_tag(:meta, with: { property: 'og:video:url', content: 'foo' })
      end

      it 'produces a twitter:player meta tag' do
        expect(subject.iframe_video_url('foo')).to have_tag(:meta, with: { name: 'twitter:player', content: 'foo' })
      end

      it 'produces a og:video:type meta tag' do
        expect(subject.iframe_video_url('foo')).to have_tag(:meta, with: { property: 'og:video:type', content: 'text/html' })
      end
    end

    describe '#stream_video_url' do
      it 'produces a og:video:url meta tag' do
        expect(subject.stream_video_url('foo')).to have_tag(:meta, with: { property: 'og:video:url', content: 'foo' })
      end

      it 'produces a twitter:player:stream meta tag' do
        expect(subject.stream_video_url('foo')).to have_tag(:meta, with: { name: 'twitter:player:stream', content: 'foo' })
      end

      it 'produces a og:video:type meta tag' do
        expect(subject.stream_video_url('foo')).to have_tag(:meta, with: { property: 'og:video:type', content: 'video/mp4' })
      end
    end

    describe '#site_name' do
      it 'produces a og:site_name meta tag' do
        expect(subject.site_name('foo')).to have_tag(:meta, with: { property: 'og:site_name', content: 'foo' })
      end
    end

    describe '#card_type' do
      it 'produces a twitter:card meta tag' do
        expect(subject.card_type('foo')).to have_tag(:meta, with: { name: 'twitter:card', content: 'foo' })
      end
    end

    describe '#video_size' do
      it 'produces twitter:player meta tags' do
        result = subject.video_size([10, 20])
        expect(result).to have_tag(:meta, with: { name: 'twitter:player:width', content: '10' })
        expect(result).to have_tag(:meta, with: { name: 'twitter:player:height', content: '20' })
      end

      it 'produces og:video meta tags' do
        result = subject.video_size([10, 20])
        expect(result).to have_tag(:meta, with: { property: 'og:video:width', content: '10' })
        expect(result).to have_tag(:meta, with: { property: 'og:video:height', content: '20' })
      end
    end
  end
end


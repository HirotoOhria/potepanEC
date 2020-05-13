require 'rails_helper'

RSpec.describe Spree::Product, type: :model do
  viewable_type = { viewable_type: 'Spree::Variant' }

  let(:product)               { create(:product, shipping_category_id: 1) }
  let(:master_variant)        { product.master }
  let(:master_variant_image1) { create(:image, viewable_type, viewable_id: master_variant.id) }
  let(:master_variant_image2) { create(:image, viewable_type, viewable_id: master_variant.id) }
  let(:other_variant)         { create(:variant, product: product) }
  let(:other_variant_image1)  { create(:image, viewable_type, viewable_id: other_variant.id) }
  let(:other_variant_image2)  { create(:image, viewable_type, viewable_id: other_variant.id) }

  describe '#main_image' do
    subject { product.main_image }

    context 'product.imagesに画像があるとき' do
      before do
        master_variant_image1
        master_variant_image2
      end

      it { should eq master_variant_image1 }
    end

    context 'product.imagesに画像がなく、product.variant_imagesに画像があるとき' do
      before do
        master_variant
        other_variant_image1
        other_variant_image2

        puts "product.variant_images.all => #{product.variant_images.all}"
        puts "product.variant_images.first => #{product.variant_images.first}"
      end

      it { should eq other_variant_image1 }
    end

    context 'product.imagesにも、product.variant_imagesにも画像がないとき' do
      before do
        master_variant
        other_variant
      end

      subject { product.main_image.attributes }

      it { should eq Spree::Image.new.attributes }
    end
  end

  describe '#show_images' do
    subject { product.show_images }

    context 'product.imagesに画像があるとき' do
      before do
        master_variant_image1
        master_variant_image2
      end

      it { should eq product.images }
    end

    context 'product.imagesに画像がなく、product.variant_imagesに画像があるとき' do
      before do
        master_variant
        other_variant_image1
        other_variant_image2
      end

      it { should eq product.variant_images }
    end

    context 'product.imagesにも、product.variant_imagesにも画像がないとき' do
      before do
        master_variant
        other_variant
      end

      subject(:show_images) { product.show_images }

      it '返すコレクションの個数は1であること' do
        expect(show_images.count).to eq 1
      end

      it '返すコレクションの1個目のオブジェクトの属性は、Spree::Image.newの属性であること' do
        expect(sho_images.first.attributes).to eq Spree::Image.new.attributes
      end
    end
  end
end

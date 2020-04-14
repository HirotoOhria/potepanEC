module Potepan::CategoriesHelper
  def take_option_values(option_type_name)
    Spree::OptionType.find_by(name: option_type_name).option_values
  end

  def render_carousel_image(product, carousel_type: :large)
    if product.images.empty?
      (render 'potepan/spree/images/image',
              carousel_type: carousel_type,
              image_counter: 0, image: Spree::Image.new)
    else
      (render product.images, carousel_type: carousel_type)
    end
  end
end

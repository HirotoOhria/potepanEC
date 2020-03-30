require 'rails_helper'

RSpec.describe "static_pages/show.html.erb", type: :view do

  it "正常なビューを返す" do
    product = FactoryBot.create(:spree_product)
    visit "/potepan/static_pages/#{product.id}"

    expect(page).to have_title "#{product.name} | potepanec"
    expect(page).to have_content product.name
    expect(page).to have_content product.price.round
    expect(page).to have_content product.description
  end
end

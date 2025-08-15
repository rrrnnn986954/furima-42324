FactoryBot.define do
  factory :item do
    item_name { Faker::Commerce.product_name }
    item_explanation { Faker::Lorem.sentence }
    category_id { 2 }
    situation_id { 2 }
    shipping_charge_id { 2 }
    shipping_area_id { 2 }
    delivery_time_id { 2 }
    amount { 500 }

    after(:build) do |item|
      item.image.attach(
        io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'sample.png')),
        filename: 'sample.png',
        content_type: 'image/png'
      )
    end

    association :user
  end
end

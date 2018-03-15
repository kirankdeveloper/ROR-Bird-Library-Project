FactoryGirl.define do

  factory :fly, class: fly  do |a|
    name 'Duck'
    family 'Availabile in eastzone'
    continents ["Africa"]
    added  Time.now.strftime("%Y-%m-%d")
    visible true
    created_at Time.now
    updated_at Time.now
  end

  factory :fly_obj, class: fly  do |a|
    name 'Duck'
    family 'Availabile in WestZone'
    added  Time.now.strftime("%Y-%m-%d")
    visible true
    created_at Time.now
    updated_at Time.now
  end

  factory :invalid_fly_array, class: fly  do |a|
    name 'Duck'
    family 'Availabile in WestZone'
    added  Time.now.strftime("%Y-%m-%d")
    visible true
    created_at Time.now
    updated_at Time.now
    continents ["Africa Antaritica"]
  end

  factory :valid_continents, class: fly  do |a|
    name 'Duck'
    family 'Availabile in WestZone'
    added  Time.now.strftime("%Y-%m-%d")
    visible true
    created_at Time.now
    updated_at Time.now
    continents ["Africa","Antarctica"]
  end

  factory :in_valid_continents, class: fly  do |a|
    name 'Duck'
    family 'Availabile in WestZone'
    added  Time.now.strftime("%Y-%m-%d")
    visible true
    created_at Time.now
    updated_at Time.now
    continents ["Africa","Apple"]
  end

end

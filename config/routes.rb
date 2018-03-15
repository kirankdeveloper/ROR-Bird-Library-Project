Rails.application.routes.draw do

  scope module: :api, defaults: {format: 'json'} do
    scope module: :fly do
      get 'flys' => 'flys#flys_list', as: :flys
      post'flys' =>'flys#add_fly'
      get 'flys/:id' => 'flys#display_fly'
      delete 'flys/:id' => 'flys#remove_fly'
    end
  end

end

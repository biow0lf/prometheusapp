SUPPORTED_LOCALES = /(en|ru|uk|br)/

Prometheusapp::Application.routes.draw do |map|
  get "search/index"

  get "srpm/main"

  get "team/info"

  get "home/index"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  match '(/:locale)/api', :to => 'pages#api', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/project', :to => 'pages#project', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/rss', :to => 'pages#rss', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/news', :to => 'pages#news', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/security', :to => 'pages#security', :constraints => { :locale => SUPPORTED_LOCALES }

  match '(/:locale)/packages', :to => 'home#groups_list', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/packages/:group(/:group2(/:group3))', :to => 'home#bygroup', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/people', :to => 'home#packagers_list', :constraints => { :locale => SUPPORTED_LOCALES }

  match '(/:locale)/team/:name', :to => 'team#info', :constraints => { :locale => SUPPORTED_LOCALES }

  match '(/:locale)/packager/:login', :to => 'packager#info', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/packager/:login/srpms', :to => 'packager#srpms', :constraints => { :locale => SUPPORTED_LOCALES }
#  match '(/:locale)/packager/:login/acls', :to => 'packager#acls', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/packager/:login/gear', :to => 'packager#gear', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/packager/:login/bugs', :to => 'packager#bugs', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/packager/:login/allbugs', :to => 'packager#allbugs', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/packager/:login/repocop', :to => 'packager#repocop', :constraints => { :locale => SUPPORTED_LOCALES }
#  map.connect '/packager/:login/repocop/rss', :controller => 'packager', :action => 'repocop'
#  map.connect '/:locale/packager/:login/repocop/rss', :controller => 'packager', :action => 'repocop'


  match '(/:locale)/srpm/:branch/:name', :to => 'srpm#main', :constraints => { :locale => SUPPORTED_LOCALES, :branch => /[^\/]+/, :name => /[^\/]+/ }
  match '(/:locale)/srpm/:branch/:name/changelog', :to => 'srpm#changelog', :constraints => { :locale => SUPPORTED_LOCALES, :branch => /[^\/]+/, :name => /[^\/]+/ }
  match '(/:locale)/srpm/:branch/:name/spec', :to => 'srpm#rawspec', :constraints => { :locale => SUPPORTED_LOCALES, :branch => /[^\/]+/, :name => /[^\/]+/ }
  match '(/:locale)/srpm/:branch/:name/get', :to => 'srpm#download', :constraints => { :locale => SUPPORTED_LOCALES, :branch => /[^\/]+/, :name => /[^\/]+/ }
  match '(/:locale)/srpm/:branch/:name/gear', :to => 'srpm#gear', :constraints => { :locale => SUPPORTED_LOCALES, :branch => /[^\/]+/, :name => /[^\/]+/ }
  match '(/:locale)/srpm/:branch/:name/bugs', :to => 'srpm#bugs', :constraints => { :locale => SUPPORTED_LOCALES, :branch => /[^\/]+/, :name => /[^\/]+/ }
  match '(/:locale)/srpm/:branch/:name/allbugs', :to => 'srpm#allbugs', :constraints => { :locale => SUPPORTED_LOCALES, :branch => /[^\/]+/, :name => /[^\/]+/ }
  match '(/:locale)/srpm/:branch/:name/repocop', :to => 'srpm#repocop', :constraints => { :locale => SUPPORTED_LOCALES, :branch => /[^\/]+/, :name => /[^\/]+/ }

  #  map.connect '/srpm/:branch/:name/repocop.:format', :controller => 'home', :action => 'repocop', :requirements => { :name => /[^\/]+/ }
  #  map.connect '/:locale/srpm/:branch/:name/repocop.:format', :controller => 'home', :action => 'repocop', :requirements => { :name => /[^\/]+/ }
  #  map.connect '/repocop', :controller => 'repocop', :action => 'index'
  #  map.connect '/repocop/by-test/:testname', :controller => 'repocop', :action => 'bytest'

  # legacy begin
  match '(/:locale)/packager/:login/srpms?sort=age&order=desc', :to => 'packager#srpms', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/packager/:login/srpms?sort=age&order=asc', :to => 'packager#srpms', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/packager/:login/srpms?sort=name&order=desc', :to => 'packager#srpms', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/packager/:login/srpms?sort=name&order=asc', :to => 'packager#srpms', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/packager/:login/srpms?sort=status&order=desc', :to => 'packager#srpms', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/packager/:login/srpms?sort=status&order=asc', :to => 'packager#srpms', :constraints => { :locale => SUPPORTED_LOCALES }
  # legacy end

  match '(/:locale)/search', :to => 'search#index', :constraints => { :locale => SUPPORTED_LOCALES }
  match '(/:locale)/find.shtml', :to => 'search#index', :constraints => { :locale => SUPPORTED_LOCALES }

  # /api begin
  match '/api/v1/count/:vendor/:branch', :to => 'api#count'

  match '/api/v1/maintainers', :to => 'api#maintainers'
  match '/api/v1/maintainer/:login', :to => 'api#maintainer_name' # -- вернёт Full Name маинтейнера
  match '/api/v1/maintainer/:login/acl', :to => 'api#maintainer_acl' # -- вернёт список acl для маинтейнера Сизифе
  match '/api/v1/maintainer/:login/gear', :to => 'api#maintainer_gear' # -- вернёт список gear репозиторией маинтейнера
  match '/api/v1/maintainer/:login/bugs', :to => 'api#maintainer_bugs' # -- вернёт список номеров не закрытых багов на маинтейнере
  match '/api/v1/maintainer/:login/allbugs', :to => 'api#maintainer_allbugs' # -- вернёт список номеров всех багов на маинтейнере
  match '/api/v1/maintainer/:login/repocop', :to => 'api#maintainer_repocop' # -- отчёты repocop для всех пакетов маинтейнера

  match '/api/v1/srpm/:branch/:name', :to => 'api#srpm_info' # -- информация о пакете :name из бранча :branch
  match '/api/v1/srpm/:branch/:name/changelog', :to => 'api#srpm_changelog' # -- changelog пакета
  match '/api/v1/srpm/:branch/:name/spec', :to => 'api#srpm_spec' # -- spec пакета
  match '/api/v1/srpm/:branch/:name/get', :to => 'api#srpm_get' # -- список из src.rpm и бинарных пакетов собранных их этого src.rpm пакета
  match '/api/v1/srpm/:branch/:name/gear', :to => 'api#srpm_gear' # -- список из маинтейнеров у которых в gear есть пакет :name
  match '/api/v1/srpm/:branch/:name/bugs', :to => 'api#srpm_bugs' # -- номера открытых багов на пакет :name
  match '/api/v1/srpm/:branch/:name/allbugs', :to => 'api#srpm_allbugs' # -- номера всех багов на пакет :name
  match '/api/v1/srpm/:branch/:name/repocop', :to => 'api#srpm_repocop' # -- отчёты repocop на пакет :name
  # /api end

  match '(/:locale)', :to => 'home#index', :constraints => { :locale => SUPPORTED_LOCALES }

  root :to => 'home#index'

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get :short
  #       post :toggle
  #     end
  #
  #     collection do
  #       get :sold
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get :recent, :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end

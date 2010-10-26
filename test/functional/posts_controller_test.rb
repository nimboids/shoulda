require 'test_helper'
require 'posts_controller'

# Re-raise errors caught by the controller.
class PostsController; def rescue_action(e) raise e end; end

class PostsControllerTest < ActionController::TestCase
  fixtures :all

  def setup
    @controller = PostsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    @post       = Post.find(:first)
  end

  # autodetects the :controller
  should route(:get,    '/posts').to(:action => :index)
  # explicitly specify :controller
  should route(:post,   '/posts').to(:controller => :posts, :action => :create)
  # non-string parameter
  should route(:get,    '/posts/1').to(:action => :show, :id => 1)
  # string-parameter
  should route(:put,    '/posts/1').to(:action => :update, :id => "1")
  should route(:delete, '/posts/1').to(:action => :destroy, :id => 1)
  should route(:get,    '/posts/new').to(:action => :new)

  # Test the nested routes
  should route(:get,    '/users/5/posts').to(:action => :index, :user_id => 5)
  should route(:post,   '/users/5/posts').to(:action => :create, :user_id => 5)
  should route(:get,    '/users/5/posts/1').to(:action => :show, :id => 1, :user_id => 5)
  should route(:delete, '/users/5/posts/1').to(:action => :destroy, :id => 1, :user_id => 5)
  should route(:get,    '/users/5/posts/new').to(:action => :new, :user_id => 5)
  should route(:put,    '/users/5/posts/1').to(:action => :update, :id => 1, :user_id => 5)

  context "Logged in" do
    setup do
      @request.session[:logged_in] = true
    end

    context "viewing posts for a user" do
      setup do
        get :index, :user_id => users(:first)
      end
      should respond_with(:success)
      should render_template(:index)
      should assign_to(:user).with_kind_of(User).with { users(:first) }
      should_fail do
        should assign_to(:user).with_kind_of(Post)
      end
      should_fail do
        should assign_to(:user).with { posts(:first) }
      end
      should assign_to(:posts)
      should_not assign_to(:foo)
      should_not assign_to(:bar)
    end

    context "viewing posts for a user with rss format" do
      setup do
        get :index, :user_id => users(:first), :format => 'rss'
        @user = users(:first)
      end
      should respond_with(:success)
      should respond_with_content_type('application/rss+xml')
      context "with a symbol" do
        should respond_with_content_type(:rss)
      end
      context "with a regexp" do
        should respond_with_content_type(/rss/)
      end
      should set_session(:mischief).to(nil)
      should set_session(:special).to('$2 off your next purchase')
      should set_session(:special_user_id).to { @user.id }
      should set_session(:false_var).to(false)
      should_fail do
        should set_session(:special_user_id).to('value')
      end
      should assign_to(:user)
      should assign_to(:posts)
      should_not assign_to(:foo)
      should_not assign_to(:bar)
    end

    context "viewing a post on GET to #show" do
      setup { get :show, :user_id => users(:first), :id => posts(:first) }
      should render_with_layout(:wide)
      context "with a symbol" do # to avoid redefining a test
        should render_with_layout(:wide)
      end
      should assign_to(:false_flag)
      should_fail do
        should set_the_flash.to(/.*/)
      end
    end

    context "on GET to #new" do
      setup { get :new, :user_id => users(:first) }
      should_not render_with_layout
      should_not set_the_flash
    end

    context "on POST to #create" do
      setup do
        post :create, :user_id => users(:first),
                      :post    => { :title => "first post",
                                    :body  => 'blah blah blah' }
      end

      should redirect_to('the created post') { user_post_url(users(:first),
                                                             assigns(:post)) }
      should_fail do
        should redirect_to('elsewhere') { user_posts_url(users(:first)) }
      end

      should set_the_flash.to(/success/)
      should_fail do
        should_not set_the_flash
      end
    end
  end

end

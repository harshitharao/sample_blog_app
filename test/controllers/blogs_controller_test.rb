require 'test_helper'

class BlogsControllerTest < ActionController::TestCase
  setup do
    @blog = blogs(:one)
    @tag1 = tags(:one)
    @tag2 = tags(:two)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:blogs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create blog" do
    Blog.destroy_all
    assert_difference('Blog.count') do
      post :create, blog: { content: @blog.content, title: @blog.title }
    end

    blog = Blog.last

    assert_equal false, blog.tags.pluck(:name).include?('MyStringTag1')
    assert_redirected_to blog_path(assigns(:blog))
  end

  test "should create blog with tags" do
    Blog.destroy_all

    tag1 = @tag1.name
    tag2 = @tag2.name
    assert_difference('Blog.count') do
      post :create, blog: { content: @blog.content, title: @blog.title }, tags: {"#{tag1}" => tag1, "#{tag2}" => tag2}
    end

    blog = Blog.last

    assert_equal true, blog.tags.pluck(:name).include?('MyStringTag1')
    assert_equal true,blog.tags.pluck(:name).include?('MyStringTag2')
    assert_redirected_to blog_path(assigns(:blog))
  end

  test "should show blog" do
    get :show, id: @blog
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @blog
    assert_response :success
  end

  test "should update blog" do
    patch :update, id: @blog, blog: { content: @blog.content, title: @blog.title }
    assert_redirected_to blog_path(assigns(:blog))
  end

  test "should update blog tags only if it is unique" do
    Blog.destroy_all
    tag1 = @tag1.name
    blog = Blog.create title: @blog.title, content: @blog.content

    assert_equal false, blog.tags.pluck(:name).include?('MyStringTag1')
    assert_equal 0,blog.tags.count

    patch :update, id: blog, blog: { content: blog.content, title: blog.title }, tags: {"#{tag1}" => tag1 }

    assert_equal true, Blog.last.tags.pluck(:name).include?('MyStringTag1')
    assert_equal 1,Blog.last.tags.count

    patch :update, id: Blog.last.id, blog: { content: "Hellooo", title: Blog.last.title }, tags: {"#{tag1}" => tag1 }

    assert_equal "Hellooo", Blog.last.content
    assert_equal 1,Blog.last.tags.count
    assert_redirected_to blog_path(assigns(:blog))
  end

  test "should destroy blog" do
    assert_difference('Blog.count', -1) do
      delete :destroy, id: @blog
    end

    assert_redirected_to blogs_path
  end
end

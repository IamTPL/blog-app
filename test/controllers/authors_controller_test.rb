require 'test_helper'

class AuthorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @author = authors(:one) # Sử dụng fixture từ authors.yml
    @other_author = authors(:two)
    @author_three = authors(:three)
    log_in_as(@author_three)
  end

  # Test cho action index
  test 'should get index' do
    get authors_url
    assert_response :success
  end

  # Test cho action show
  test 'should show author' do
    get author_url(@author)
    assert_response :success
  end

  # Test cho action new (hiển thị form tạo mới)
  test 'should get new' do
    get new_author_url
    assert_response :success
  end

  # Test cho action create (tạo mới author)
  test 'should create author' do
    assert_difference('Author.count') do
      post authors_url,
           params: { author: { name: 'New Author', email: 'newauthor@example.com', age: 51, password: 'password',
                               password_confirmation: 'password' } }
    end

    assert_redirected_to author_url(Author.last) # Kiểm tra redirect sau khi tạo thành công
  end

  # Test cho action update (cập nhật author)
  test 'should update author' do
    patch author_url(@author_three), params: { author: { name: 'Updated Name' } }
    assert_redirected_to author_url(@author_three) # Kiểm tra tên đã được cập nhật
  end

  # Test cho action destroy (xóa author)
  test 'should destroy author' do
    assert_difference('Author.count', -1) do
      delete author_url(@author_three)
    end
    assert_redirected_to authors_url
  end

  # test "should get index" do
  #   get authors_url
  #   assert_response :success
  # end

  # test "should get new" do
  #   get new_author_url
  #   assert_response :success
  # end

  # test "should create author" do
  #   assert_difference('Author.count') do
  #     post authors_url, params: { author: { age: @author.age, name: @author.name } }
  #   end

  #   assert_redirected_to author_url(Author.last)
  # end

  # test "should show author" do
  #   get author_url(@author)
  #   assert_response :success
  # end

  # test "should get edit" do
  #   get edit_author_url(@author)
  #   assert_response :success
  # end

  # test "should update author" do
  #   patch author_url(@author), params: { author: { age: @author.age, name: @author.name } }
  #   assert_redirected_to author_url(@author)
  # end

  # test "should destroy author" do
  #   assert_difference('Author.count', -1) do
  #     delete author_url(@author)
  #   end

  #   assert_redirected_to authors_url
  # end
end

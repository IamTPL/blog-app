require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @article = articles(:one) # Sử dụng fixture từ articles.yml
    @other_article = articles(:two)
    @article_three = articles(:three)
    @author = authors(:one)
    @other_author = authors(:two)
    @author_three = authors(:three)
    log_in_as(@author_three)
  end

  # Test cho action index
  test 'should get index' do
    get articles_url
    assert_response :success
  end

  # Test cho action show
  test 'should show article' do
    get article_url(@article_three)
    assert_response :success
  end

  # Test cho action new (hiển thị form tạo mới)
  test 'should get new' do
    get new_article_url
    assert_response :success
  end

  # Test cho action create (tạo mới article)
  test 'should create article' do
    assert_difference('Article.count') do
      post articles_url,
           params: { article: { title: 'New Article', description: 'This is a new article.',
                                author_id: authors(:three).id,
                                article_detail_attributes: { word_count: 101, topic: 'Funny', published_at: Time.zone.now } } }
    end

    assert_redirected_to article_url(Article.last) # Kiểm tra redirect sau khi tạo thành công
  end

  # Test cho action update (cập nhật article)
  test 'should update article' do
    patch article_url(@article_three), params: { article: { title: 'Updated Title' } }
    assert_redirected_to article_url(@article_three) # Kiểm tra tên đã được cập nhật
  end

  # Test cho action destroy (xóa article)
  test 'should destroy article' do
    assert_difference('Article.count', -1) do
      delete article_url(@article_three)
    end
    assert_redirected_to articles_url
  end
end

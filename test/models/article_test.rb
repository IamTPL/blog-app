require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  def setup
    # Tạo một đối tượng Author mẫu, cần thiết vì Article phải thuộc về Author
    @author = Author.create(
      name: 'John Doe',
      email: 'john@example.com',
      password: 'password',
      password_confirmation: 'password'
    )

    # Đối tượng Article mẫu hợp lệ
    @article = Article.new(
      title: 'Sample Article',
      description: 'This is a sample article description.',
      author: authors(:one) # Giả sử có một fixture cho author hoặc sử dụng author ở trên
    )
  end

  # Kiểm tra nếu đối tượng Article hợp lệ
  test 'should be valid' do
    assert @article.valid?
  end

  # Kiểm tra nếu title không được để trống
  test 'title should be present' do
    @article.title = '   '
    assert_not @article.valid?
    assert_includes @article.errors[:title], "can't be blank"
  end

  # Kiểm tra nếu description không được để trống
  test 'description should be present' do
    @article.description = '   '
    assert_not @article.valid?
    assert_includes @article.errors[:description], "can't be blank"
  end

  # Kiểm tra độ dài tối thiểu của title
  test 'title should not be too short' do
    @article.title = 'aa' # Quá ngắn (ít hơn 3 ký tự)
    assert_not @article.valid?
    assert_includes @article.errors[:title], 'is too short (minimum is 3 characters)'
  end

  # Kiểm tra độ dài tối đa của title
  test 'title should not be too long' do
    @article.title = 'a' * 21 # Quá dài (hơn 20 ký tự)
    assert_not @article.valid?
    assert_includes @article.errors[:title], 'is too long (maximum is 20 characters)'
  end

  # Kiểm tra độ dài tối thiểu của description
  test 'description should not be too short' do
    @article.description = 'aa' # Quá ngắn (ít hơn 3 ký tự)
    assert_not @article.valid?
    assert_includes @article.errors[:description], 'is too short (minimum is 3 characters)'
  end

  # Kiểm tra độ dài tối đa của description
  test 'description should not be too long' do
    @article.description = 'a' * 51 # Quá dài (hơn 50 ký tự)
    assert_not @article.valid?
    assert_includes @article.errors[:description], 'is too long (maximum is 50 characters)'
  end

  # Kiểm tra quan hệ belongs_to author
  test 'should belong to an author' do
    @article.author = nil
    assert_not @article.valid?, 'Article without an author should be invalid'
    assert_includes @article.errors[:author], 'must exist'
  end

  # Kiểm tra nested attributes cho article_detail
  test 'should accept nested attributes for article_detail' do
    @article.article_detail_attributes = { topic: 'Horror', word_count: 100, published_at: Time.zone.now }
    assert @article.valid?, 'Article should be valid with nested attributes for article_detail'
  end
end

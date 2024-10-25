require 'test_helper'

class AuthorTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test 'should be valid with valid attributes' do
    author = Author.new(
      name: 'John Doew',
      email: 'johnnnn@example.com',
      password: 'password123',
      password_confirmation: 'password123'
    )
    assert author.valid? # Kiểm tra nếu đối tượng hợp lệ
  end

  # Kiểm tra trùng lặp email
  test 'should not allow duplicate emails' do
    # Tạo một đối tượng Author đầu tiên với email
    Author.create!(
      name: 'John Doew',
      email: 'johnnnnn@example.com',
      password: 'password123',
      password_confirmation: 'password123'
    )

    # Tạo một đối tượng Author khác với cùng email
    duplicate_author = Author.new(
      name: 'Jane Doew',
      email: 'johnnnnn@example.com', # Trùng email với bản ghi trước
      password: 'password123',
      password_confirmation: 'password123'
    )

    # Kiểm tra xem đối tượng thứ hai không hợp lệ do email trùng lặp
    assert_not duplicate_author.valid?, 'Author with duplicate email should be invalid'
    assert_includes duplicate_author.errors[:email], 'has already been taken'
  end

  # Kiểm tra định dạng email không hợp lệ
  test 'should not allow invalid emails' do
    author = Author.new(
      name: 'John Doew',
      email: 'johnexample' # Email không hợp lệ
    )
    assert_not author.valid?
    assert_includes author.errors[:email], 'is invalid'
  end

  # Kiểm tra mật khẩu confirmation không khớp
  test 'password confirmation does not match' do
    author = Author.new(
      name: 'John Doew',
      email: 'john@exmal.com',
      password: 'password123',
      password_confirmation: 'password'
    )
    assert_not author.valid?
    assert_includes author.errors[:password_confirmation], "doesn't match Password"
  end

  # Kiểm tra trùng mật khẩu đã được mã hóa
  test 'password should be encrypted' do
    author = Author.new(
      name: 'John Doew',
      email: 'johnnnn@example.com',
      password: 'password123',
      password_confirmation: 'password123'
    )
    author.save!

    # Kiểm tra rằng trường password_digest không trống và chứa mật khẩu đã mã hóa
    assert_not_nil author.password_digest
    assert_not_equal author.password_digest, 'password123' # Không được lưu trữ mật khẩu gốc

    # Kiểm tra xem mật khẩu có được mã hóa đúng chuẩn BCrypt không
    assert BCrypt::Password.new(author.password_digest).is_password?('password123')
  end
end

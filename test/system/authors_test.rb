require 'application_system_test_case'

class AuthorsTest < ApplicationSystemTestCase
  setup do
    @author = Author.new(
      name: 'John Doew',
      email: 'abc@example.com',
      password: 'password',
      password_confirmation: 'password'
    )
    @author_login = authors(:three)
    login_user(@author_login)
  end

  test 'visiting the index' do
    visit authors_url
    assert_selector 'h1', text: 'Authors'
  end

  test 'creating a Author' do
    visit authors_url
    click_on 'New Author'

    fill_in 'Name', with: @author.name
    fill_in 'Age', with: @author.age
    fill_in 'Email', with: @author.email
    fill_in 'Password', with: @author.password
    fill_in 'Password confirmation', with: @author.password_confirmation
    click_on 'Create Author'

    assert_text 'Author was successfully created'
    click_on 'Back'
  end

  test 'updating a Author' do
    visit authors_url
    click_on 'Edit', match: :first

    fill_in 'Email', with: @author_login.email
    fill_in 'Name', with: @author_login.name
    fill_in 'Age', with: @author_login.age
    click_on 'Update Author'

    assert_text 'Author was successfully updated'
    click_on 'Back'
  end

  test 'destroying a Author' do
    visit authors_url
    page.accept_confirm do
      # Tìm chính xác email và chọn Destroy
      find(:xpath, "//tr[td[contains(text(), 'marqueen@example.com')]]//a[text()='Destroy']").click
    end

    assert_text 'Author was successfully destroyed'
  end
end

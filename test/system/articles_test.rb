require 'application_system_test_case'

class ArticlesTest < ApplicationSystemTestCase
  setup do
    @article = articles(:three)
    @author = authors(:one)
    @author_login = authors(:three)
    login_user(@author_login)
  end

  test 'visiting the index' do
    visit articles_url
    assert_selector 'h1', text: 'List of Articles'
  end

  test 'creating a Article' do
    visit articles_url
    click_on 'New Article'

    fill_in 'Title', with: @article.title
    fill_in 'Description', with: @article.description
    select  @article.author.name, from: 'Select Author'
    fill_in 'Word Count', with: @article.article_detail.word_count
    fill_in 'Topic', with: @article.article_detail.topic

    click_on 'Create Article'

    assert_text 'Article was successfully created'
    click_on 'Back'
  end

  test 'updating a Article' do
    visit articles_url
    first(:xpath, "//div[contains(., 'By: #{@article.author.name}')]//a[text()='Edit']").click

    fill_in 'Title', with: @article.title
    fill_in 'Description', with: @article.description
    select  @article.author.name, from: 'Select Author'
    fill_in 'Word Count', with: @article.article_detail.word_count
    fill_in 'Topic', with: @article.article_detail.topic
    click_on 'Update Article'

    assert_text 'Article was successfully updated'
    click_on 'Back'
  end

  test 'destroying a Article' do
    visit articles_url
    page.accept_confirm do
      first(:xpath, "//div[contains(., 'By: #{@article.author.name}')]//a[text()='Delete']").click
    end

    assert_text 'Article was successfully destroyed'
  end
end

# Compare this snippet from test/fixtures/authors.yml:
# one:
#   name: John Doew
#   email:
# end

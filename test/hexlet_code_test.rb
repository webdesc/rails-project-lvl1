# frozen_string_literal: true

require 'test_helper'
require 'hexlet_code/tag'

class HexletCodeTest < Minitest::Test
  User = Struct.new(:name, :job, :gender, keyword_init: true)

  def setup
    @user = User.new name: 'rob'
  end

  def test_that_it_has_a_version_number
    refute_nil ::HexletCode::VERSION
  end

  def test_create_single_tag_without_attrs
    expected = '<br>'
    actual = HexletCode::Tag.build('br')
    assert_equal expected, actual
  end

  def test_create_single_tag_with_attrs
    expected = '<input type="submit" value="Save">'
    actual = HexletCode::Tag.build('input', type: 'submit', value: 'Save')
    assert_equal expected, actual
  end

  def test_create_pair_tag_without_attrs
    expected = '<label>Email</label>'
    actual = HexletCode::Tag.build('label') { 'Email' }
    assert_equal expected, actual
  end

  def test_create_pair_tag_with_attrs
    expected = '<a href="https://www.jopa.ru" class="link">go</a>'
    actual = HexletCode::Tag.build('a', href: 'https://www.jopa.ru', class: 'link') { 'go' }
    assert_equal expected, actual
  end

  def test_create_textarea
    expected = '<textarea cols="666" rows="555">value</textarea>'
    actual = HexletCode::Tag.build('textarea', cols: '666', rows: '555') { 'value' }
    assert_equal expected, actual
  end

  def test_create_form_without_action
    expected = '<form action="#" method="post"></form>'
    actual = HexletCode.form_for @user do |i|
    end
    assert_equal expected, actual
  end

  def test_create_form_with_action
    expected = '<form action="/users" method="post"></form>'
    actual = HexletCode.form_for @user, url: '/users' do |i|
    end
    assert_equal expected, actual
  end

  def test_create_form_fields
    user = User.new name: 'rob', job: 'hexlet', gender: 'm'
    expected = File.new('./test/fixtures/mock-form.html').read.chomp
    actual = HexletCode.form_for user, url: '/users' do |f|
      f.input :name
      f.input :job, as: :text, cols: '200', rows: '400'
      f.input :gender, as: :select, collection: %w[m f]
    end
    assert_equal expected, actual
  end

  def test_create_form_fields_submit
    user = User.new job: 'hexlet'
    expected = File.new('./test/fixtures/mock-form-submit.html').read.chomp
    actual = HexletCode.form_for user do |f|
      f.input :name
      f.input :job
      f.submit
    end
    assert_equal expected, actual
  end
end

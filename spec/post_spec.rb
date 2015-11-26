require_relative "../models/post.rb"
require "spec_helper"
require 'active_record'


describe Post do
  it 'has a valid title' do
    expect(build(:vehicle)).to be_valid
  end

  it 'has a valid body' do
    expect(build(:vehicle, year: nil)).to_not be_valid
  end
end
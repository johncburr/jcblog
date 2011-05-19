class BlogpController < ApplicationController
  def create
    @blogp = Blogp.new(params[:blogp])
  end

  def new
    @blogp
  end
end
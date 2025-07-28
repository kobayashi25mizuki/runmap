class SearchesController < ApplicationController
  before_action :authenticate_user!

	def search
    @model = params[:model]
    @content = params[:content]

    if @model == 'user'
      @records = User.search_for(@content)
    elsif @model == 'post'
      @records = Post.search_for(@content)
    elsif @model == 'group'
      @records = Group.search_for(@content)
    elsif @model == 'genre'
      @records = Post.search_for(@content, :genre)
    end
  end
end
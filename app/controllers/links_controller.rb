class LinksController < ApplicationController
  before_action :set_link, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, except: [:index, :show]

  def index
    @links = Link.order("cached_votes_up DESC").page(params[:page])
  end

  def show
  end

  def tag
    @links = Link.tagged_with(params[:tag])
  end
  
  def new
    @link = current_user.links.build
  end
  
  def edit
  end
  
  def create
    @link = current_user.links.build(link_params)
    
    if @link.save
      redirect_to @link, notice: 'Link was successfully created.'
    else
      render :new 
    end
  end
  
  def update
    if @link.update(link_params) 
      redirect_to @link, notice: 'Link was successfully updated.'
    else
      render :edit
    end
  end
  
  def destroy
    @link.destroy
    redirect_to links_url, notice: 'Link was successfully destroyed.'
  end
  
  def upvote
    @link = Link.find(params[:id])
    @link.upvote_by current_user
    redirect_to :back
  end
  
  def downvote
    @link = Link.find(params[:id])
    @link.downvote_by current_user
    redirect_to :back
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_link
      @link = Link.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def link_params
      params.require(:link).permit(:title, :url, :all_tags)
    end
end

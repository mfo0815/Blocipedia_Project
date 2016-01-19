class WikisController < ApplicationController

  def index
      @wikis = wiki.all
      @wikis.each_with_index do |wiki, index|
        if index % 5 == 0
          wiki.title = "SPAM"
        end
      end
    end

  def show
    @wiki = wiki.find(params[:id])
  end

  def new
    @wiki = wiki.new
  end

  def create
    @wiki = wiki.new
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]

    if @wiki.save
      flash[:notice] = "wiki was saved."
      redirect_to @wiki
    else
      flash[:error] = "There was an error saving the wiki. Please try again."
      render :new
    end
  end

  def edit
    @wiki = wiki.find(params[:id])
  end
  def update
  @wiki = wiki.find(params[:id])
  @wiki.title = params[:wiki][:title]
  @wiki.body = params[:wiki][:body]

  if @wiki.save
    flash[:notice] = "wiki was updated."
    redirect_to @wiki
  else
    flash[:error] = "There was an error saving the wiki. Please try again."
    render :edit
  end
end

def destroy
     @wiki = wiki.find(params[:id])

     if @wiki.destroy
       flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
       redirect_to wikis_path
     else
       flash[:error] = "There was an error deleting the wiki."
       render :show
     end
   end
end

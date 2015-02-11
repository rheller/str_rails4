class PagesController < ApplicationController
 before_filter :admin_required, :except => [:show]


  def index
    @pages = Page.all
  end

  def edit
    find_page
  end

  def show
    find_page
  end
 
  def new
  #create a new empty object, in case need to retain for validation
       @page = Page.new
  end

 
  def create
  @page = Page.new(pages_params)
  if @page.save
     flash[:notice] = 'Page created successfully'
     redirect_to :action => 'show', :id => @page.id
  else
       render :action => "new"
  end
end


  def update
    find_page
    if @page.update_attributes(pages_params)
         flash[:notice] = 'Page updated succcessfully'
         redirect_to :action => 'show', :id => params[:id]
    else
         render :action => "edit"
    end
  end


  def destroy
    find_page

    @page.destroy
     flash[:notice] = 'Page deleted.'
     redirect_to :controller => 'explanations', :action => 'index'
  end




protected

 def find_page
   @page = nil
    begin  
      page = Page.friendly.find(params[:id])
    rescue ActiveRecord::RecordNotFound => exc
      logger.info("No such page exception: #{exc.message}")
#redirect doesn't seem to work inside rescue block
    end
    if page
        @page = page
    else
      flash[:notice] = "Page unavailable"
      redirect_to :controller => 'explanations', :action => 'index'
    end
end


def admin_required
 unless (current_user.present? && current_user.admin)
   redirect_to sign_in_path
 end
end

  def pages_params
     params.require(:page).permit(:title, :part1, :extra, :embedded, :part2, :links, :prev_slug, :next_slug, :prev_page, :next_page)
  end

end

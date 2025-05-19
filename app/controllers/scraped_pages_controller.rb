class ScrapedPagesController < ApplicationController
  def index
    @scraped_pages = current_user.scraped_pages.order(created_at: :desc).page(params[:page]).per(10)

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def show
    @scraped_page = current_user.scraped_pages.find(params[:id])
    @links = @scraped_page.links.page(params[:page]).per(20)
  end

  def new
    @scraped_page = ScrapedPage.new
  end

  def create
    @scraped_page = current_user.scraped_pages.new(scraped_page_params)
    @scraped_page.status = :pending
    @scraped_page.title = "Processing..."
  
    if @scraped_page.save
      ScrapePageJob.perform_later(@scraped_page.id)
  
      respond_to do |format|
        format.turbo_stream 
        format.html { redirect_to scraped_pages_path, notice: "Scraping started" }
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            "new_scraped_page",
            partial: "form",
            locals: { scraped_page: @scraped_page }
          )
        end
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def rescan
    @scraped_page = ScrapedPage.find(params[:id])
    @scraped_page.update(status: :pending)

    ScrapePageJob.perform_later(@scraped_page.id)

    redirect_to @scraped_page, notice: "The page scan has been started again."
  end

  private

  def scraped_page_params
    params.require(:scraped_page).permit(:url)
  end
end

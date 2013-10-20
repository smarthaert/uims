#---
# Excerpted from "Agile Web Development with Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rails4 for more book information.
#---
class StoreController < ApplicationController
  skip_before_filter :authorize
  def index
    if params[:set_locale]
      redirect_to store_path(locale: params[:set_locale])
    else
      #@stocks = Stock.order(:goodsname).page(1).per(10)
      @stocks = Stock.where("pid like ? and goodsname like ?", "%#{params[:pid]}%", "%#{params[:goodsname]}%").order(:goodsname).page(params[:page])
      #@stocks = Stock.find_by_sql("select s.id,s.stid,s.stname,s.pid,s.barcode,s.goodsname,s.size,s.color,s.amount,s.volume,s.unit,s.inprice,if(h.hprice is null,s.pfprice,h.hprice) as pfprice,s.bundle,s.discount,s.baseline,s.remark,s.created_at,s.updated_at,s.picture_file_name,s.picture_content_type,s.picture_file_size,s.picture_updated_at from stocks s left join (select pid,goodsname,hprice from memberprices where custid='1' and current_timestamp() between startdate and enddate) h on s.pid=h.pid")
      #@stocks = Stock.order(:goodsname)
      @stocks.each do |stock|
         mp = Memberprice.where("pid = ? and custid = ? and current_timestamp() between startdate and enddate", stock.pid, session[:customer_id]).first
         if mp
           stock.zprice = mp.hprice
         end
      end
      if session[:customer_id]
        @cart = current_cart
      end
    end

    # latest = Product.latest
    # fresh_when etag: latest, last_modified: latest.created_at.utc
    # expires_in 10.minutes, public: true
  end
end

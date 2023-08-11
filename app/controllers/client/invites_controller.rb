class Client::InvitesController < ApplicationController
  before_action :authenticate_user!

  def show
    @promote_url = "#{request.host_with_port}#{new_user_registration_path}?promoter=#{current_user.email}"
    qrcode = RQRCode::QRCode.new(@promote_url)

    @svg = qrcode.as_svg(offset: 0, color: "000", shape_rendering: 'crispEdges',
                         module_size: 6, standalone: true)
  end
end



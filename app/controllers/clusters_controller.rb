class ClustersController < ApplicationController
  def show
    @cluster = Cluster.find_by(name: params[:name])
    render template: 'site/clusters/show'
  end

end
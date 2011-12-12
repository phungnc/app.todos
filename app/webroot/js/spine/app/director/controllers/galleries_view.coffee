Spine ?= require("spine")
$      = Spine.$

class GalleriesView extends Spine.Controller
  
  @extend Spine.Controller.Drag
  
  elements:
    '.items'                  : 'items'
    
  headerTemplate: (items) ->
    $("#headerGalleryTemplate").tmpl(items)

  template: (items) ->
    $("#galleriesTemplate").tmpl(items)

  constructor: ->
    super
    @list = new GalleryList
      el: @items
      template: @template
    @header.template = @headerTemplate
    Gallery.bind('refresh change', @proxy @change)
    Spine.bind('show:galleries', @proxy @showit)

  change: ->
    console.log 'GalleriesView::change'
    items = Gallery.all()
    @render items
    
  render: (items) ->
    console.log 'GalleriesView::render'
    @list.render items
    @header.render()
    
  showit: ->
    @parent.trigger('change:toolbar', Gallery)
    Spine.trigger('change:canvas', @)
    
  newAttributes: ->
    if User.first()
      name   : 'New Name'
      user_id : User.first().id
    else
      User.ping()
  
  create: (e) ->
    console.log 'GalleriesView::create'
    Spine.trigger('create:gallery')

  destroy: (e) ->
    console.log 'GalleriesView::destroy'
    Spine.trigger('destroy:gallery')


module?.exports = GalleriesView
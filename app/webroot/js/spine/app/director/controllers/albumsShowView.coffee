Spine ?= require("spine")
$      = Spine.$

class AlbumsShowView extends Spine.Controller

  elements:
    ".content"                : "showContent"
    "#views .views"           : "views"
    ".content .sortable"      : "sortable"
    '.optGallery'             : 'btnGallery'
    '.optAlbum'               : 'btnAlbum'
    '.optUpload'              : 'btnUpload'
    '.optGrid'                : 'btnGrid'
    '.content .items'         : 'items'
    '.header'                 : 'header'
    '.toolbar'                : 'toolBar'
    
  events:
    "click .optEdit"          : "edit"
    "click .optEmail"         : "email"
    "click .optGallery"       : "toggleGallery"
    "click .optAlbum"         : "toggleAlbum"
    "click .optUpload"        : "toggleUpload"
    "click .optGrid"          : "toggleGrid"
    'dblclick .draghandle'    : 'toggleDraghandle'
    #'sortupdate .items'       : 'sortupdate'
    'dragcreate .items'       : 'dragcreate'
    'drag .items'             : 'drag'

  albumsTemplate: (items) ->
    $("#albumsTemplate").tmpl items

  toolsTemplate: (items) ->
    $("#toolsTemplate").tmpl items

  constructor: ->
    super
    @list = new Spine.AlbumList
      el: @items,
      template: @albumsTemplate
    Album.bind("change", @proxy @render)
    Gallery.bind "update", @proxy @renderHeader
    Spine.App.bind('save:gallery', @proxy @save)
    Spine.App.bind('change:selectedGallery', @proxy @change)
    @bind('save:gallery', @proxy @save)
    @bind("toggle:view", @proxy @toggleView)

    @toolBarList = []

    @create = @edit

    $(@views).queue("fx")
    
  children: (sel) ->
    @el.children(sel)

  loadJoinTables: ->
    AlbumsImage.records = Album.joinTableRecords

  change: (item, mode) ->
    console.log 'AlbumsShowView::change'
    console.log mode if mode
    @current = item
    @render()
    @[mode]?(item)

  render: (album) ->
    console.log 'AlbumsShowView::render'
    
    if @current
      joinedItems = GalleriesAlbum.filter(@current.id)
      items = for val in joinedItems
        Album.find(val.album_id)
    else
      items = Album.filter()
      
    @renderHeader()
    @list.render items, album
    @initDraggables()
   
  renderHeader: (item) ->
    console.log 'AlbumsShowView::renderHeader'
    gallery = item or @current
    if gallery
      @header.html '<h2>Albums for Gallery ' + gallery.name + '</h2>'
    else
      @header.html '<h2>Albums Overview</h2>'

  renderToolBar: ->
    @toolBar.html @toolsTemplate @toolBarList
    @refreshElements()
  
  initDraggables: ->
    sortOptions =
      connectWith: '#sidebar .items'
      
    dragOptions =
      opacity: 0.35
      revert: true
      revertDuration: 1000
      scope: 'albums'
      stack: '#sidebar'
      connectToSortable: '.show .content .sortable'
    dropOptions = {}
    #@sortable.sortable sortOptions
    @sortable.children().draggable dragOptions
    #@droppable = $('#sidebar .items')
    #@droppable.droppable dropOptions
    #console.log @draggable.children()
    console.log @droppable

  drag: (e, ui) ->
    #@items.children('li').each (index) ->
    #console.log e

  dragcreate: (e, ui) ->
    #console.log e
    #@items.children('li').each (index) ->
      #todo = Todos.Collections.Todos.get($(this).attr('id').replace("todo-", ""));
#      if(todo.get('order') != index) todo.save({
#        order: index

  edit: ->
    App.albumsEditView.render()
    App.albumsManager.change(App.albumsEditView)

  email: ->
    return if ( !@current.email ) 
    window.location = "mailto:" + @current.email

  renderViewControl: (controller, controlEl) ->
    active = controller.isActive()

    $(".options .opt").each ->
      if(@ == controlEl)
        $(@).toggleClass("active", active)
      else
        $(@).removeClass("active")

    @toolBar.empty() unless App.hmanager.hasActive()

  animateView: ->
    hasActive = ->
      if App.hmanager.hasActive()
        return App.hmanager.enableDrag()
      App.hmanager.disableDrag()
    
    
    height = ->
      if hasActive() then parseInt(App.hmanager.currentDim)+"px" else "7px"
    
    @views.animate
      height: height()
      400

  toggleGallery: (e) ->
    @toolBarList = [
      {name: 'Show Gallery', klass: 'optEdit'}
      {name: 'Edit Gallery', klass: 'optEdit'}
    ]
    @trigger("toggle:view", App.gallery, e.target)

  toggleAlbum: (e) ->
    @toolBarList = [
      {name: 'Show Album', klass: 'optEdit'}
      {name: 'Edit Album', klass: 'optEdit'}
    ]
    @trigger("toggle:view", App.album, e.target)

  toggleUpload: (e) ->
    @toolBarList = [
      {name: 'Show Upload', klass: 'optEdit'}
      {name: 'Edit Upload', klass: 'optEdit'}
    ]
    @trigger("toggle:view", App.upload, e.target)

  toggleGrid: (e) ->
    @toolBarList = [
      {name: 'Show Grid', klass: 'optEdit'}
      {name: 'Edit Grid', klass: 'optEdit'}
    ]
    @trigger("toggle:view", App.grid, e.target)

  toggleView: (controller, control) ->
    isActive = controller.isActive()
    
    if(isActive)
      App.hmanager.trigger("change", false)
    else
      @activeControl = $(control)
      App.hmanager.trigger("change", controller)
    
    @renderToolBar()
    @renderViewControl controller, control
    @animateView()
  
  toggleDraghandle: ->
    @activeControl.click()

module?.exports = AlbumsView
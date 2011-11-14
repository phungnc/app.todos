
class Album extends Spine.Model
  @configure "Album", 'title', 'description', 'count', 'user_id'

  @extend Spine.Model.Ajax
  @extend Spine.Model.AjaxRelations
  @extend Spine.Model.Filter
  @extend Spine.Model.Extender

  @caches: [global:[]]

  @selectAttributes: ['title']

  @url: ->
    '' + base_url + @className.toLowerCase() + 's'

  @nameSort: (a, b) ->
    aa = (a or '').title?.toLowerCase()
    bb = (b or '').title?.toLowerCase()
    return if aa == bb then 0 else if aa < bb then -1 else 1

  @foreignModels: ->
    'Gallery':
      className             : 'Gallery'
      joinTable             : 'GalleriesAlbum'
      foreignKey            : 'album_id'
      associationForeignKey : 'gallery_id'
    'Photo':
      className             : 'Photo'
      joinTable             : 'AlbumsPhoto'
      foreignKey            : 'album_id'
      associationForeignKey : 'image_id'

  
  @cacheList: (recordID) =>
    id = recordID or @record.id
    return @caches[0].global unless id
    for item in @caches
      return item[id] if item[id]

  @cache: (record, url) ->
    cache = @cacheList record?.id
    for item in cache
      return item[url] if item[url]

  @addToCache: (url, uri) ->
    cache = @cacheList Album.record?.id
    dummy = {}
    dummy[url] = uri
    cache.push dummy
    cache
    
  @emptyCache: (id) ->
    originalList = @cacheList(id)
    originalList[0...originalList.length] = []
    originalList
    
  init: (instance) ->
    return unless instance
    newSelection = {}
    newSelection[instance.id] = []
    @constructor.selection.push(newSelection)
    
    cache = {}
    cache[instance.id] = []
    @constructor.caches.push(cache)
    
  selectAttributes: ->
    result = {}
    result[attr] = @[attr] for attr in @constructor.selectAttributes
    result

  select: (id) ->
    #id should be gallery.id
    ga = GalleriesAlbum.filter(id)
    for record in ga
      return true if record.album_id is @id
      
Spine.Model.Album = Album
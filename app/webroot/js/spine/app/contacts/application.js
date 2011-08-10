jQuery(function($){
  
  window.App = Spine.Controller.create({
    el: $("body"),
    
    elements: {
      "#sidebar": "sidebarEl",
      "#contacts": "contactsEl"
    },
    
    init: function(){
      console.log(window.App)
      this.sidebar = Sidebar.init({
        el: this.sidebarEl
      });
      this.contact = Contacts.init({
        el: this.contactsEl
      });
      
      Contact.fetch();
    }
  }).init();
  
});
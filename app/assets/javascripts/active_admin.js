//= require active_admin/base
//= require activeadmin/quill_editor/quill
//= require activeadmin/quill_editor_input


//add rich text
const scriptTag = document.createElement("script");
scriptTag.src = "https://cdn.ckeditor.com/4.17.2/standard/ckeditor.js";

scriptTag.onload = function() {
    const ckEditorInstances = document.getElementsByClassName('ckEditor');
    for (let i = 0; i < ckEditorInstances.length; i++) {
        // Initialize CKEditor for each instance
        CKEDITOR.replace(ckEditorInstances[i]);
    }
};

document.head.appendChild(scriptTag);

$(document).ready(function () {
    $(".editable_location").each(function () {
        addEditableForLocation(this);
    });
});

function addEditableForLocation(element) {
    var label = $(element);
    label.after('<input type ="text" style="display:none" />');
    var textbox = $(element).next();

    var name = element.id.split('_')[0];
    var id = element.id.split('_')[1];

    textbox[0].name = "location[" + name + "]";
    textbox.val(label.html());

    label.click(function () {
        $(this).hide();
        $(this).next().show().focus();
    });

    textbox.focusout(function () {
        var data = {};
        data[this.name] = this.value;

        $.ajax({
            data: data,
            method: "PUT",
            url: "/location/" + id
        });

        $(this).hide();
        $(this).prev().html($(this).val());
        $(this).prev().show();
    });
}
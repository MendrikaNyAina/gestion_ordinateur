function call(url,method, data,actionSuccess, actionError) {
     //console.log(data);
     //console.log(JSON.stringify(data));
     $.ajax({
          url: url,
          type: method,
          data: JSON.stringify(data),
          dataType: 'json',
          contentType: 'application/json; charset=utf-8',
          success: function (response) {
               actionSuccess(response);
          },
          error: function (xhr, status, error) {
               actionError(xhr, status,error);
          }
     });
}

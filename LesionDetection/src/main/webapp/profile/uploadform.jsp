<html>
    <head>
        <title>File Uploading Form</title>
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
        <script>
            function uploadFile() {
                document.getElementById("fileUpload").submit();
            }
        </script>
        <script src="https://kit.fontawesome.com/d16c32e0f3.js" crossorigin="anonymous"></script>

        <style>
            .fileContainer {
                overflow: hidden;
                position: relative;
            }

            .fileContainer [type=file] {
                cursor: inherit;
                display: block;
                font-size: 999px;
                filter: alpha(opacity=0);
                min-height: 100%;
                min-width: 100%;
                opacity: 0;
                position: absolute;
                right: 0;
                text-align: right;
                top: 0;
            }
            .fileContainer {
                background: #12BBF0;
                color: white;
                font-family: tahoma, sans-serif;
                text-transform: uppercase;
                border-radius: .5em;
                float: left;
                padding: 1em;
                box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
                cursor: pointer;
            }
            .fileContainer:hover {
                box-shadow: none;
                background: darkblue;
            }
        </style>
    </head>
    <body>
    <center>
        <% String id = request.getParameter("id");
        %>
        <form action = "uploadfile.jsp?id=<%=id%>; method = "post"
              enctype = "multipart/form-data" id="fileUpload">
            <label class="fileContainer">
                <i class="fas fa-cloud-upload-alt"></i>&nbsp;Upload Image
                <input type = "file" name = "file" size = "50" onchange="uploadFile()"/>
            </label>
        </form>
    </center>
</body>

</html>
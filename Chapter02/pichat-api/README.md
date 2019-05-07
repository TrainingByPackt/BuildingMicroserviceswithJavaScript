# Pichat API

This is a Rails application that hosts the API for a fictional application
called Pichat that allows users to send messages to each other along with a
video or image.

# API

The following endpoints are implemented by this service:

### Authentication

`POST /auth/login`

Parameters:

* email - The email address identifying the user
* password - The users password.

Example:

```sh
curl -X POST http://localhost:3000/auth/login -d'email=paul@eval.ca&password=foobar123'
```

Return:

```json
{
  "auth_token": "super-secret"
}
```

The `auth_token` can then be used to authenticate subsequent requests. For example:

```sh
curl -H 'Authorization: super-secret' http://localhost:3000/messages'
```

### Posting a Message

`POST /messages`

### Adding an Attachment to a Message

To create a message attachment, send a POST request to the message attachments
endpoint. The attachment data is included in the request payload as a base64
encoded string.

`POST /messages/:id/attachments`

#### Request Body

```json
{
  "media_type": 1,
  "file": {
    "name": "myimage.jpg",
    "data": "iVBORw0KGgoAAA..."
  }
}
```

#### Response

```json
{
  "url": "http://path/to/file"
}
```

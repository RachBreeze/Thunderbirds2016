export default function (API_URL, $resource) {

    let transformResponse = (data) => {
        if (typeof data === 'string') {
            data = JSON.parse(data);
        };

        if (Array.isArray(data) === true) {
            return data.map(Tweet.transformResponse);
        };

        data.DateTime = new Date(data.DateTime);

        return data;
    }

    let options = {
        'uniqueID':'383A353A39363A3A3139'
    };

    let actions = {
        query: {
            transformResponse
        },
        get: {
            transformResponse
        }
    };

    let Post = $resource(`${API_URL}/api/Twitter`, options, actions);

    Post.transformResponse = transformResponse;

    Post.prototype.getURL = function () {
        return this.PostUrl;
    }

    return Post;
}
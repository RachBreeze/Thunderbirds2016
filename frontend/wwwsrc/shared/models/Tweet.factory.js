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

    let Tweets = $resource(`${API_URL}/api/Twitter`, options, actions);

    Tweets.transformResponse = transformResponse;

    Tweets.prototype.getURL = function () {
        let url = `https://twitter.com/${this.TwitterHandle}/status/${this.Id}`;
        console.log("URL IS:", url);
        return url;
    }

    return Tweets;
}
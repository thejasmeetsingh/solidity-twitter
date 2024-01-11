// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

contract Twitter {
    struct Tweet {
        uint id;
        address author;
        string content;
        uint256 timestamp;
        uint256 likes;
    }

    mapping(address => Tweet[]) public tweets;
    uint256 public maxTweetLength = 280;
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(owner == msg.sender, "You are not the owner");
        _;
    }

    function changeTweetLenght(uint256 newTweetLength) public onlyOwner {
        maxTweetLength = newTweetLength;
    }

    function createTweet(string memory _tweet) public {
        require(bytes(_tweet).length <= maxTweetLength, "Tweet is to looonngg!");

        Tweet memory newTweet = Tweet({
            id: tweets[msg.sender].length,
            author: msg.sender,
            content: _tweet,
            timestamp: block.timestamp,
            likes: 0
        });

        tweets[msg.sender].push(newTweet);
    }

    function getTweet(uint idx) public view returns (Tweet memory) {
        return tweets[msg.sender][idx];
    }

    function getTweets() public view returns (Tweet[] memory) {
        return tweets[msg.sender];
    }

    function likeTweet(address author, uint id) external {
        require(tweets[author][id].id == id, "Tweet does not exists");
        tweets[author][id].likes++;
    }

    function dislikeTweet(address author, uint id) external {
        require(tweets[author][id].id == id, "Tweet does not exists");
        require(tweets[author][id].likes > 0, "Tweet has no likes");
        tweets[author][id].likes--;
    }
}

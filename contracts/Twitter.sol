// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

contract Twitter {
    struct Tweet {
        address author;
        string content;
        uint256 timestamp;
        uint256 likes;
    }

    mapping(address => Tweet[]) public tweet;
    uint16 constant MAX_TWEET_LENGTH = 280;

    function createTweet(string memory _tweet) public {
        require(bytes(_tweet).length <= MAX_TWEET_LENGTH, "Tweet is to looonngg!");

        Tweet memory newTweet = Tweet({
            author: msg.sender,
            content: _tweet,
            timestamp: block.timestamp,
            likes: 0
        });

        tweet[msg.sender].push(newTweet);
    }

    function getTweet(uint idx) public view returns (Tweet memory) {
        return tweet[msg.sender][idx];
    }

    function getTweets() public view returns (Tweet[] memory) {
        return tweet[msg.sender];
    }
}
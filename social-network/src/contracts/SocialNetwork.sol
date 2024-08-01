pragma solidity ^0.5.0;

contract SocialNetwork{
	string public name;
	mapping(uint => Post) public posts;
	uint public PostCount = 0;

	struct Post{
		uint id;
		string content;
		uint tipAmount;
		address author;
	}

	event PostCreated(
		uint id,
		string content,
		uint tipAmount,
		address author
	);

	constructor() public{
		name = "shivam social network";
	}

	function createPost(string memory _content) public{
//Require valid content
	require(bytes(_content).length > 0);

	//increment the post count
		PostCount++;
	//Create the post
		posts[PostCount] = Post(PostCount, _content, 0, msg.sender);
	//Trigger Event
		emit PostCreated(PostCount, _content, 0, msg.sender);
	}
}
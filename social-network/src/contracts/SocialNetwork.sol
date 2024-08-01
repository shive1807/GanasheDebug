pragma solidity ^0.5.0;

contract SocialNetwork{
	string public name;
	mapping(uint => Post) public posts;
	uint public PostCount = 0;

	struct Post{
		uint id;
		string content;
		uint tipAmount;
		address payable author;
	}

	event PostCreated(
		uint id,
		string content,
		uint tipAmount,
		address payable author
	);

	event PostTipped(
		uint id,
		string content,
		uint tipAmount,
		address payable author
	);

	constructor() public{
		name = "This is my first post";
	}

	function createPost(string memory _content) public{
//Require valid content
	require(bytes(_content).length > 0, "Content cannot be empty");

	//increment the post count
		PostCount++;
	//Create the post
		posts[PostCount] = Post(PostCount, _content, 0, msg.sender);
	//Trigger Event
		emit PostCreated(PostCount, _content, 0, msg.sender);
	}

	function tipPost(uint _id) public payable{
		require(_id > 0 && _id <= PostCount);

		//fetch the post
		Post memory _post = posts[_id]; 
		
		//fetch the author
		address payable _author = _post.author;
		address(_author).transfer(msg.value);

		//increment the tip tipAmount
		_post.tipAmount += msg.value;
		//update the post

		posts[_id] = _post;
		

		//trigger an event
		emit PostTipped(PostCount, _post.content, _post.tipAmount, _author);
	}
}
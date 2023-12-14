pragma solidity ^0.8.0;

contract TodoList {
    address public owner;
    uint public taskCount;

    struct Task {
        uint id;
        string content;
        bool completed;
    }

    mapping(uint => Task) public tasks;

    event TaskCreated(uint id, string content, bool completed);


    constructor() {
        owner = msg.sender;
        taskCount = 0;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    function createTask(string memory _content) public onlyOwner {
        taskCount++;
        tasks[taskCount] = Task(taskCount, _content, false);
        emit TaskCreated(taskCount, _content, false);
    }

    function completeTask(uint _taskId) public onlyOwner {
        require(_taskId > 0 && _taskId <= taskCount, "Invalid task ID");
        tasks[_taskId].completed = true;
    }

}

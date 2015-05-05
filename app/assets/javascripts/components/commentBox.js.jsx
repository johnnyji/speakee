var CommentBox = React.createClass({
  getInitialState: function() {
    return {
      isEditing: false,
      commentBody: this.props.commentBody,
      resultMessage: null,
      deleted: false
    }
  },
  changeEditingState: function() {
    if (this.state.isEditing) {
      this.setState({ isEditing: false });
    } else {
      this.setState({ isEditing: true });
    } 
  },
  handleEditResult: function(resultMessage, commentBody) {
    this.setState({
      resultMessage: resultMessage,
      commentBody: commentBody
    });
  },
  handleDeleteResult: function(resultMessage, condition) {
    this.setState({
      resultMessage: resultMessage,
      deleted: condition
    });
  },
  render: function() {
    if (this.state.isEditing) {
      return (
       <EditingComment updateCommentPath={this.props.updateCommentPath} postEditedComment={this.postEditedComment} commenterName={this.props.commenterName} commenterLinks={this.props.commenterLinks} commentBody={this.state.commentBody} onEditResult={this.handleEditResult} exitEditing={this.changeEditingState} originalCommentBody={this.state.commentBody}/> 
      );
    } else if (this.state.deleted) {
      return null;
    } else {
      return (
        <div className="comment-box">
          {this.state.resultMessage && <p>{this.state.resultMessage}</p>}
          <h3><a href={this.props.commenterLink}>{this.props.commenterName}</a></h3>
          <CommenterLinks editLink={this.changeEditingState} commentPath={this.props.updateCommentPath} onDeleteResult={this.handleDeleteResult}/>
          <p>{this.state.commentBody}</p>
        </div>
      );
    }
  }
});




var CommenterLinks = React.createClass({
  deleteComment: function() {
    var self = this;
    $.ajax({
      method: "DELETE",
      url: self.props.commentPath,
      success: function() {
        self.props.onDeleteResult(null, true);
      },
      error: function() {
        self.props.onDeleteResult("Sorry something went wrong", false);
      }
    });
  },
  render: function() {
    return (
      <div className="commenter-links">
        <button onClick={this.props.editLink}>Edit</button>
        <button onClick={this.deleteComment}>Delete</button>
      </div>
    )
  }
});




var EditingComment = React.createClass({
  updateComment: function(e) {
    var self = this;
    e.preventDefault();
    var commentTextarea = e.target.getElementsByTagName("textarea")[0];
    this.props.exitEditing();
    $.ajax({
      method: "PUT",
      url: self.props.updateCommentPath,
      data: { comment: { body: commentTextarea.value } },
      success: function() {
        self.props.onEditResult("Comment successfully posted!", commentTextarea.value);
      },
      error: function() {
        self.props.onEditResult("Oops something went wrong!", commentTextarea.defaultValue);
      }
    });
  },
  render: function() {
    return (
      <div className="comment-box">
        <h3><a href={this.props.commenterLink}>{this.props.commenterName}</a></h3>
        <form className="edit-comment-form" onSubmit={this.updateComment}>
          <textarea defaultValue={this.props.commentBody}/><br/>
          <input type="submit" value="Post Comment"/>
        </form>
      </div>
    );   
  }
});
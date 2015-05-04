var CommentBox = React.createClass({
  render: function() {
    return (
      <div className="comment-box">
        <h3><a href={this.props.commenterLink}>{this.props.commenterName}</a></h3>
        <p>{this.props.commentBody}</p>
      </div>
    );
  }
});

var CommenterLinks = React.createClass({
  render: function() {
    return (
      <div className="commenter-links">
        <a href={this.props.editLink}>Edit</a>
        <a href={this.props.deleteLink}>Delete</a>
      </div>
    )
  }
});
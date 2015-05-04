var CommentForm = React.createClass({
  render: function() {
    return (
      <form>
        <input type="text" value={this.props.commentBody} >
      </form>
    )
  }
}); 
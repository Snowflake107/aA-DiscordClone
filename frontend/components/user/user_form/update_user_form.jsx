import React from 'react';
import { withRouter } from 'react-router-dom'

class UpdateUserForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      id: props.user.id,
      username: props.user.username,
      email: props.user.email,
      oldPW: "",
      newPW: "",
      editMode: false,
      pwMode: false
    };
    this.handleSubmit = this.handleSubmit.bind(this);
    this.changeInput = this.changeInput.bind(this);
    this.deleteAccount = this.deleteAccount.bind(this);
    this.switchMode = this.switchMode.bind(this);
    this.showPWFields = this.showPWFields.bind(this);
    this.showErrors = this.showErrors.bind(this);
  }

  componentWillUnmount() {
    this.props.clearErrors();
  }

  showErrors(key) {
    let errors = this.props.errors[key];
    const label = document.getElementById(`${key}-label`);
    const input = document.getElementById(`${key}-input`);
    if (errors) {
      label.classList.add("red-text")
      input.classList.add("red-border")
      if (errors[0] === "can't be blank") {
        return <span>- This field is required</span>
      } else if (errors[0] === "has already been taken") {
        return <span>- That email already has an account</span>
      } else {
        return <span>- {errors}</span>
      }
    } else if (label && input) {
      label.classList.remove("red-text");
      input.classList.remove("red-border");
    }
  }

  handleSubmit(event) {
    event.preventDefault();
    const userObj = {
      username: this.state.username,
      email: this.state.email
    }
    this.props.editUser(this.state.id, userObj, this.state.oldPW, this.state.newPW)
      .then(() => {this.setState({editMode: false})});
  }

  changeInput(key) {
    return (event) => {
      this.setState({ [key]: event.target.value });
    }
  }

  deleteAccount(event) {
    event.preventDefault();
    this.props.deleteAccount(this.props.user)
      .then(() => this.props.history.push(`/login`));
  }

  showPWFields(event) {
    event.preventDefault();
    this.setState({ pwMode: true})
  }

  passwordFields() {
    if (this.state.pwMode) {
      return (
        <section>
          <label id="old_password-label">CURRENT PASSWORD {this.showErrors("old_password")}
            <input id="old_password-input" type="password" value={this.state.oldPW} onChange={this.changeInput("oldPW")} />
          </label>
          <label id="new_password-label">NEW PASSWORD {this.showErrors("new_password")}
            <input id="new_password-input" type="password" value={this.state.newPW} onChange={this.changeInput("newPW")} />
          </label>
        </section>
      )
    } else {
      return (
        <button onClick={this.showPWFields}>Change Password?</button>
      )
    }
  }

  showEditForm() {
    return (
      <form onSubmit={this.handleSubmit} className="form-type-1">
        <div>
          <img src={this.props.user.image_url} />
          <section>
            <label id="username-label">USERNAME {this.showErrors("username")}
              <input id="username-input" type="text" value={this.state.username} onChange={this.changeInput("username")} />
            </label>
            <label id="email-label">EMAIL {this.showErrors("email")}
              <input id="email-input" type="text" value={this.state.email} onChange={this.changeInput("email")} />
            </label>
            {this.passwordFields()}
          </section>
        </div>
        <div>
          <button onClick={this.deleteAccount}>Delete Account</button>
          <div>
            <button onClick={this.switchMode}>Cancel</button>
            <input type="submit" value="Save" />
          </div>
        </div>        
      </form>
    )
  }

  switchMode(event) {
    event.preventDefault();
    this.props.clearErrors();
    this.setState({
      username: this.props.user.username,
      email: this.props.user.email,
      oldPW: "",
      newPW: "",
      editMode: !this.state.editMode, 
      pwMode: false
    });
  }

  showSummary() {
    const tag = this.props.user.tag;
    const tagIdxStart = tag.indexOf("#");
    const tagNum = tag.slice(tagIdxStart);
    return (
      <section id="show-user-info">
        <img src={this.props.user.image_url}/>
        <div id="show-user-info-center">
          <div>
            <h2>USERNAME</h2>
            <span>{this.props.user.username}</span>
            <span>{tagNum}</span>
          </div>
          <div>
            <h2>EMAIL</h2>
            <span>{this.props.user.email}</span>
          </div>
        </div>
        <button onClick={this.switchMode}>Edit</button>
      </section>
    )
  }

  render() {
    return (
      <div id="update-user-form">
        {this.state.editMode && this.showEditForm() || this.showSummary()}
      </div>


    )
  }
}

export default withRouter(UpdateUserForm);
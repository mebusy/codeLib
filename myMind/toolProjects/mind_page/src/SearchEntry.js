import React, { Component } from 'react';
import './App.css';

import { Form, Input, Button, Checkbox, Modal } from 'antd';

import {  BACKEND_IP } from './Config' ; 

const FormItem = Form.Item;
const { TextArea } = Input;





const formItemLayout = {
  labelCol: { span: 4 },
  wrapperCol: { span: 8 },
};
const formTailLayout = {
  labelCol: { span: 4 },
  wrapperCol: { span: 8, offset: 4 },
};


class SearchEntryUnwrap extends Component{

  handleSubmit = (e) => {
    e.preventDefault();
    this.props.form.validateFields((err, values) => {
      if (!err) {
        // console.log('Received values of form: ', values);

        // submit form data to api
        fetch( "http://" + BACKEND_IP +  ":7000/searchentry" ,  {
          method: 'POST',
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
          body: JSON.stringify( values)
        })
          .then(res => res.json())
          .then(
            (result) => {
                if (result.err) {
                    alert( result.err ); 
                } else {
                    // this.props.form.resetFields();
                    // this.props.switchPage(7);
                }
            },
            // Note: it's important to handle errors here
            // instead of a catch() block so that we don't swallow
            // exceptions from actual bugs in components.
            (error) => {
                alert( error ) ;
            }
          )     

      }
    });
  }


    render() {
      const { getFieldDecorator } = this.props.form;
      
      return (
        <Form onSubmit={this.handleSubmit}>

        <FormItem {...formItemLayout} label="key">
          {getFieldDecorator('key', {
            rules: [{
              required: true,
              message: 'Please input what to search ',
            }],
          })(
            <Input placeholder="Please input what to search" />
          )}
        </FormItem>

        <FormItem {...formItemLayout} label="depth">
          {getFieldDecorator('depth', {
            initialValue: 1, 
            rules: [{
              required: true,
              message: 'Please input search depth  ',
            }],
          })(
            <Input placeholder="Please input search depth"  />
          )}
        </FormItem>

        <FormItem
          wrapperCol={{ span: 12, offset: 5 }}
        >
          <Button type="primary" htmlType="submit">
            search
          </Button>
        </FormItem>

        </Form>
      );
    }
};

const SearchEntry = Form.create()(SearchEntryUnwrap);
export default SearchEntry ;



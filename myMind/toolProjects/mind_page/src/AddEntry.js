import React, { Component } from 'react';
import './App.css';

import { Form, Input, Button, Checkbox, Modal } from 'antd';

import {  BACKEND_IP } from './Config' ; 

const FormItem = Form.Item;
const { TextArea } = Input;


const confirm = Modal.confirm;



const formItemLayout = {
  labelCol: { span: 4 },
  wrapperCol: { span: 8 },
};
const formTailLayout = {
  labelCol: { span: 4 },
  wrapperCol: { span: 8, offset: 4 },
};


class AddEntryUnwrap extends Component{
    forceUpdateConfirm = ( title, info ,newRelation, form ) => {

      confirm({
        title: title , 
        content: JSON.stringify(info) ,
        okText: '强制更新',
        onOk() {
          // console.log('OK');
            // submit form data to api
            info.relation = newRelation ; 
            fetch( "http://" + BACKEND_IP +  ":9000/updateentry" ,  {
              method: 'POST',
              headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json',
              },
              body: JSON.stringify( info)
            })
              .then(res => res.json())
              .then(
                (result) => {
                    if (result.err) {
                        alert( result.err ); 
                    } else {
                        alert( "编辑成功" );
                        form.resetFields();
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
        },
        onCancel() {
          // console.log('Cancel');
        },
      });
    }


  handleSubmit = (e) => {
    e.preventDefault();
    this.props.form.validateFields((err, values) => {
      if (!err) {
        // console.log('Received values of form: ', values);

        // submit form data to api
        fetch( "http://" + BACKEND_IP +  ":9000/addentry" ,  {
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
                if( result.err && result.action === "forceupdate" ) {
                    
                    // alert( result.action  );
                    this.forceUpdateConfirm( result.err , result.info , values.relation  , this.props.form );
                }
                else if (result.err) {
                    alert( result.err ); 
                } else {
                    alert( "编辑成功" );
                    this.props.form.resetFields();
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

        <FormItem {...formItemLayout} label="key1">
          {getFieldDecorator('key1', {
            rules: [{
              required: true,
              message: 'Please input the entry key',
            }],
          })(
            <Input placeholder="Please input the entry key" />
          )}
        </FormItem>
        <FormItem {...formItemLayout} label="key2">
          {getFieldDecorator('key2', {
            rules: [{
              required: true,
              message: 'Please input the entry key',
            }],
          })(
            <Input placeholder="Please input the entry key" />
          )}
        </FormItem>

        <FormItem {...formItemLayout} label="relation">
          {getFieldDecorator('relation', {
            rules: [{ required: true, message: 'Please input your relateion!' }],
          })(
            <TextArea rows={10} placeholder="write your comments" />  
          )}
        </FormItem>        

        <FormItem
          wrapperCol={{ span: 12, offset: 5 }}
        >
          <Button type="primary" htmlType="submit">
            Submit
          </Button>
        </FormItem>

        </Form>
      );
    }
};

const AddEntry = Form.create()(AddEntryUnwrap);
export default AddEntry ;



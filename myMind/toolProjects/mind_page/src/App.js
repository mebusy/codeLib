import React, { Component } from 'react';
// import logo from './logo.svg';
import './App.css';

// ctrl C/V
import { Layout, Menu,  Icon } from 'antd';

import HelloPage from './HelloPage.js'
import AddEntry from './AddEntry.js'



const { Header, Content, Footer, Sider } = Layout;
const SubMenu = Menu.SubMenu;

// initially select menu index
const initSelectedMenuIndex = 1
// all pages 
var pageComponents = [
    null , AddEntry , HelloPage 
] ;


class App extends Component {
    state = {
        displayedComponent  : pageComponents[ initSelectedMenuIndex ],
    };

    switchPage(index){
        this.setState({
            displayedComponent: pageComponents[index],
        })
    }

  render() {
    return (
    
      <Layout style={{ minHeight: '100vh' }}>
        <Sider
          collapsible
          //collapsed={this.state.collapsed}
          //onCollapse={this.onCollapse}
        >
          <div className="logo" />
          <Menu theme="dark" defaultSelectedKeys={['1']} mode="inline">
            <Menu.Item key="1">
              <Icon type="pie-chart" />
              <span>插入条目</span>
            </Menu.Item>
            <Menu.Item key="2">
              <Icon type="desktop" />
              <span>搜索条目</span>
            </Menu.Item>
            <SubMenu
              key="sub1"
              title={<span><Icon type="user" /><span>User</span></span>}
            >
              <Menu.Item key="3">Tom</Menu.Item>
              <Menu.Item key="4">Bill</Menu.Item>
              <Menu.Item key="5">Alex</Menu.Item>
            </SubMenu>
            <SubMenu
              key="sub2"
              title={<span><Icon type="team" /><span>Team</span></span>}
            >
              <Menu.Item key="6">Team 1</Menu.Item>
              <Menu.Item key="8">Team 2</Menu.Item>
            </SubMenu>
            <Menu.Item key="9">
              <Icon type="file" />
              <span>File</span>
            </Menu.Item>
          </Menu>
        </Sider>
        <Layout>
          <Header style={{ background: '#fff', padding: 0 }} />
          <Content style={{ margin: '0 16px' }}>
          <this.state.displayedComponent />
          </Content>
          <Footer style={{ textAlign: 'center' }}>
            Apixel ©2018
          </Footer>
        </Layout>
      </Layout>

    );
  }
}

export default App;

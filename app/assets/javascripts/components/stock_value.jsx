// Display and refresh the value of a stock
class StockValue extends React.Component {

  constructor(props) {
    super(props);
    this.state = { blink_animation : '' };
  }

  render() {
    return (
      <li className='list-group-item'>
        {this.props.title} :
        <div className={ 'js-stock-value pull-right ' + this.state.blink_animation }>
          {format_value(this.props.value)}
        </div>
      </li>
    );
  }

  // Setup a timer to refresh the stock value
  componentDidMount() {
  }

  componentWillUnmount() {
  }

  componentWillReceiveProps(nextProps) {
    if(this.props.value < nextProps.value) {
      this.setState({ blink_animation: "blink-green" });
    }else if(this.props.value > nextProps.value) {
      this.setState({ blink_animation: "blink-red" });
    }else{
      this.setState({ blink_animation: "blink-black" });
    }
    
    // I need to remove the class after the animation is finished (0.5 secs).
    setTimeout( function(){ 
      this.setState({ blink_animation: '' });
    }.bind(this), 1000 );
  }
  
  tick() {
  }
}
// Display and refresh the value of a stock
class StockValue extends React.Component {

  constructor(props) {
    super(props);
    console.log("constructor");
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
    console.log(this);
    //this.effect('highlight', 0, 500);
  }

  componentWillUnmount() {
    clearInterval(this.timerID);
  }

  componentWillReceiveProps(nextProps) {
    if(this.props.value < nextProps.value) {
      console.log("higher");
      this.setState({ blink_animation: "blink-green" });
    }else if(this.props.value > nextProps.value) {
      console.log("smaller");
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
import Foundation

class Socket
{
  let s : Int32
  let host:String
  let port:Int
  fileprivate(set) var buffer = [Int8]()
  init(host:String, port:Int)
  {
    self.host = host
    self.port = port
    s = socket(AF_INET, SOCK_STREAM, Int32(0))
    guard self.s != -1 else {
      fatalError("socket(...) failed.")
    }
  }
  
  func connect() {
    // bind socket to host and port
    var addr = sockaddr_in(sin_len: __uint8_t(MemoryLayout<sockaddr_in>.size),
                           sin_family: sa_family_t(AF_INET),
                           sin_port: Socket.porthtons(in_port_t(port)),
                           sin_addr: in_addr(s_addr: inet_addr(host)),
                           sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
    var saddr = sockaddr(sa_len: 0, sa_family: 0,
                         sa_data: (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0))
    memcpy(&saddr, &addr, Int(MemoryLayout<sockaddr_in>.size))
    if Darwin.connect(s, &saddr, socklen_t(MemoryLayout<sockaddr_in>.size)) != 0
    {
      fatalError("connect(...) failed.")
    }
  }
  
  func send(bytes:UnsafePointer<Int8>, count: Int32) -> Int
  {
    return Darwin.send(s, bytes, Int(count), 0)
  }
  
  func receive(_ count:Int) -> Int
  {
    if buffer.count < count
    {
      buffer = [Int8](repeating: 0, count: count)
    }
   
    return buffer.withUnsafeMutableBufferPointer{
      return Darwin.recv(s,  UnsafeMutableRawPointer($0.baseAddress!), count, 0)
    }
  }
  
  private static func porthtons(_ port: in_port_t) -> in_port_t {
    let isLittleEndian = Int(OSHostByteOrder()) == OSLittleEndian
    return isLittleEndian ? _OSSwapInt16(port) : port
  }
}

// main.rs
use project::run;


fn main() {
    pollster::block_on(run());
}
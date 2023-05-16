const filterButton = document.querySelector('.jsFilter');
const filterMenu = document.querySelector('.filter-menu');

if (filterButton && filterMenu) {
  filterButton.addEventListener('click', function () {
    filterMenu.classList.toggle('active');
  });
}

const gridButton = document.querySelector('.grid');
const listButton = document.querySelector('.list');
const productsWrapper = document.querySelector('.products-area-wrapper');

// 뷰 모드를 변경하는 함수
function changeViewMode(viewMode) {
  if (viewMode === 'grid') {
    listButton.classList.remove('active');
    gridButton.classList.add('active');
    productsWrapper.classList.add('gridView');
    productsWrapper.classList.remove('tableView');
  } else if (viewMode === 'list') {
    listButton.classList.add('active');
    gridButton.classList.remove('active');
    productsWrapper.classList.remove('gridView');
    productsWrapper.classList.add('tableView');
  }
}

// 뷰 모드 정보를 세션 스토리지에 저장
function saveViewModeToSessionStorage(viewMode) {
  sessionStorage.setItem('viewMode', viewMode);
}

// 세션 스토리지에서 뷰 모드 정보를 읽어와 설정
function setViewModeFromSessionStorage() {
  const viewMode = sessionStorage.getItem('viewMode');
  if (viewMode) {
    changeViewMode(viewMode);
  }
}

// 클릭 이벤트 리스너 등록
gridButton.addEventListener('click', function () {
  changeViewMode('grid');
  saveViewModeToSessionStorage('grid');
});

listButton.addEventListener('click', function () {
  changeViewMode('list');
  saveViewModeToSessionStorage('list');
});

// 페이지 로드 시 뷰 모드 설정
window.addEventListener('load', setViewModeFromSessionStorage);






var modeSwitch = document.querySelector('.mode-switch');

modeSwitch.addEventListener('click', function() {
  if (document.documentElement.classList.contains('light')) {
    // 라이트 모드를 사용하는 경우, 다크 모드로 전환
    document.documentElement.classList.remove('light');
    localStorage.setItem('mode', 'dark'); // 로컬 스토리지에 선택한 모드 저장
  } else {
    // 다크 모드를 사용하는 경우, 라이트 모드로 전환
    document.documentElement.classList.add('light');
    localStorage.setItem('mode', 'light'); // 로컬 스토리지에 선택한 모드 저장
  }
  modeSwitch.classList.toggle('active'); // 토글 스위치 업데이트
});

// 페이지 로드 시, 이전에 선택한 모드가 로컬 스토리지에서 사용 가능한 경우 해당 모드로 전환
var savedMode = localStorage.getItem('mode');
if (savedMode) {
  document.documentElement.classList.add(savedMode);
  if (savedMode === 'light') {
    modeSwitch.classList.add('active');
  }
}

// 페이지가 로드될 때 실행
window.addEventListener('load', () => {
  // 로컬 스토리지에서 모드 값을 읽어옴
  const savedMode = localStorage.getItem('mode');
  
  // 모드 값이 있으면 해당 값을 변수에 할당
  if (savedMode) {
    document.documentElement.classList.add(savedMode);
  }
});


// board-list a태그 링크로 이동되도록
const boardLinks = document.querySelectorAll('.board-list a');

boardLinks.forEach(link => {
  link.addEventListener('click', function(event) {
    event.preventDefault(); // 기본 동작 막기
    window.location.href = link.getAttribute('href'); // 링크 주소로 이동
  });
});



const sidebarList = document.querySelectorAll('.sidebar-list-item');
const activeClass = 'active';

sidebarList.forEach(item => {
  item.addEventListener('click', () => {
    sidebarList.forEach(sibling => sibling.classList.remove(activeClass));
    item.classList.add(activeClass);
  });

  const currentPath = window.location.pathname;
  const itemPath = item.querySelector('a').getAttribute('href');
  
  if (currentPath === itemPath) {
    sidebarList.forEach(sibling => sibling.classList.remove(activeClass));
    item.classList.add(activeClass);
  }
});





const accountInfoMoreBtn = document.querySelector(".account-info-more");
const accountInfoMoreContent = document.querySelector(".account-info-more-content");

// 버튼 클릭 시 메뉴 열고 닫기
accountInfoMoreBtn.addEventListener("click", function () {
  accountInfoMoreContent.classList.toggle("active");
});

// 메뉴 외 다른 곳 클릭 시 메뉴 닫기
document.addEventListener("click", function (event) {
  const target = event.target;
  if (!target.closest(".account-info-more-wrapper")) {
    accountInfoMoreContent.classList.remove("active");
  }
});